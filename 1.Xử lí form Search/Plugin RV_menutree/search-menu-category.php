<?php
define('PHPWG_ROOT_PATH', '../../');
include_once(PHPWG_ROOT_PATH . 'include/common.inc.php');
include_once(PHPWG_ROOT_PATH . 'include/functions_search.inc.php');

check_status(ACCESS_GUEST);

trigger_notify('loc_begin_search');

if (isset($_GET['key-word'], $_GET['category-menu-search'], $_GET['sub-category-menu-search'])) {
  $keyword = trim($_GET['key-word']);
  $category = $_GET['category-menu-search'] ? $_GET['category-menu-search'] : "";
  $subCategory = $_GET['sub-category-menu-search'] ? $_GET['sub-category-menu-search'] : "";


  // Kiểm tra điều kiện nếu cả ba giá trị không hợp lệ
  if ($keyword === "" && $category === "" && $subCategory === "") {
    // Chuyển hướng quay lại trang trước
    header("Location: " . $_SERVER['HTTP_REFERER']);
    exit(); // Dừng script sau khi chuyển hướng
  }
}


$search = array(
  'mode' => 'AND',
  'fields' => array()
);

// list of filters in user preferences
// allwords, cat, tags, author, added_by, filetypes, date_posted
$default_fields = array('allwords', 'cat', 'tags', 'author');
if (is_a_guest() or is_generic()) {
  $fields = $default_fields;
} else {
  $fields = userprefs_get_param('gallery_search_filters', $default_fields);
}

$words = array();
if (!empty($_GET['key-word'])) {
  $words = split_allwords($keyword);
}

if (count($words) > 0 or in_array('allwords', $fields)) {
  $search['fields']['allwords'] = array(
    'words' => $words,
    'mode' => 'AND',
    'fields' => array('file', 'name', 'comment', 'tags', 'author', 'cat-title', 'cat-desc'),
  );
}

$cat_ids = array();
if (isset($category) && $subCategory == "" && $category != "") {
  check_input_parameter('category-menu-search', $_GET, false, PATTERN_ID);
  $query = '
SELECT
    *
  FROM ' . USER_CACHE_CATEGORIES_TABLE . '
  WHERE cat_id = ' . $category . ';';

  $found_categories = query2array($query);
  if (empty($found_categories)) {
    page_not_found(l10n('Requested album does not exist'));
  }



  $cat_ids = array($category);
} else if (isset($category) &&  $category != "" &&  $subCategory != "") {
  check_input_parameter('sub-category-menu-search', $_GET, false, PATTERN_ID);

  $query = '
SELECT
    *
  FROM ' . USER_CACHE_CATEGORIES_TABLE . '
  WHERE cat_id = ' . $subCategory . ';';

  $found_categories = query2array($query);
  if (empty($found_categories)) {
    page_not_found(l10n('Requested album does not exist'));
  }

  $cat_ids = array($subCategory);
}

if (count($cat_ids) > 0 or in_array('cat', $fields)) {
  $search['fields']['cat'] = array(
    'words' => $cat_ids,
    'sub_inc' => true,
  );
}
if (count(get_available_tags()) > 0) {
  $tag_ids = array();
  if (isset($_GET['tag_id'])) {
    check_input_parameter('tag_id', $_GET, false, '/^\d+(,\d+)*$/');
    $tag_ids = explode(',', $_GET['tag_id']);
  }

  if (count($tag_ids) > 0 or in_array('tags', $fields)) {
    $search['fields']['tags'] = array(
      'words' => $tag_ids,
      'mode'  => 'AND',
    );
  }
}

if (in_array('author', $fields)) {
  // does this Piwigo has authors for current user?
  $query = '
  SELECT
    id
  FROM ' . IMAGES_TABLE . ' AS i
    JOIN ' . IMAGE_CATEGORY_TABLE . ' AS ic ON ic.image_id = i.id
  ' . get_sql_condition_FandF(
    array(
      'forbidden_categories' => 'category_id',
      'visible_categories' => 'category_id',
      'visible_images' => 'id'
    ),
    ' WHERE '
  ) . '
    AND author IS NOT NULL
    LIMIT 1
;';



  $first_author = query2array($query);

  if (count($first_author) > 0) {
    $search['fields']['author'] = array(
      'words' => array(),
      'mode' => 'OR',
    );
  }
}



foreach (array('added_by', 'filetypes', 'date_posted') as $field) {
  if (in_array($field, $fields)) {
    $search['fields'][$field] = array();
  }
}



list($search_uuid, $search_url) = save_search($search);
redirect($search_url);
