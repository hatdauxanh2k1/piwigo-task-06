<?php /*
Plugin Name: RV Menu Tree
Version: 2.9.a
Plugin URI: http://piwigo.org/ext/extension_view.php?eid=238
Description: Replaces the categories in the menu bar with a nicer one (javascript).
Author: rvelices
Author URI: http://www.modusoptimus.com
*/


add_event_handler('loc_begin_page_header', 'rv_mt_begin_page_header');
function rv_mt_begin_page_header()
{
	$GLOBALS['template']->func_combine_css(array('path' => 'plugins/rv_menutree/menutree.css'));
}

add_event_handler('get_categories_menu_sql_where', 'rv_mt_get_categories_menu_sql_where', EVENT_HANDLER_PRIORITY_NEUTRAL - 1, 2);

function rv_mt_get_categories_menu_sql_where($where, $expand)
{
	if (mobile_theme())
		return $where;
	add_event_handler('blockmanager_apply', 'rv_mt_menubar_categories');

	if ($expand)
		return $where;

	global $page;
	if (!isset($page['category']))
		$where = '(id_uppercat IS NULL OR uppercats REGEXP \'^[0-9]+,[0-9]+$\')';
	else {
		$where = '(id_uppercat is NULL
  OR uppercats LIKE "' . $page['category']['upper_names'][0]['id'] . ',%"
  OR uppercats REGEXP \'^[0-9]+,[0-9]+$\')';
	}
	return $where;
}

function rv_mt_menubar_categories($menu_ref_arr)
{
	$menu = $menu_ref_arr[0];

	if (($block = $menu->get_block('mbCategories')) != null) {
		global $template, $page;
		$cat = $block->data['MENU_CATEGORIES'];
		$tree = buildTree($cat);
		$RvMenuTree = renderTreeMenu($tree);
		$_SESSION['menuApi'] = $tree;
		unset($cat);
		$rvmt_base_name  = basename(dirname(__FILE__));
		$template->assign(
			array(
				'RVMT_BASE_NAME' => $rvmt_base_name,
				'RVMT_FINAL' => $RvMenuTree
			)
		);
		$block->template = realpath(PHPWG_ROOT_PATH . 'plugins/' . $rvmt_base_name . '/template/rv_menutree_categories.tpl');
	}
}

// Hàm xây dựng cây dựa trên global_rank
function buildTree(array $categories)
{
	$tree = [];
	$references = [];

	foreach ($categories as $category) {
		$globalRank = $category['global_rank'];
		$levels = explode('.', $globalRank);

		if (count($levels) === 1) {
			// Đây là node cha (cấp đầu tiên)
			$tree[$globalRank] = ['data' => $category, 'children' => []];
			$references[$globalRank] = &$tree[$globalRank];
		} else {
			// Đây là node con
			$parentRank = implode('.', array_slice($levels, 0, -1));
			if (isset($references[$parentRank])) {
				$references[$parentRank]['children'][$globalRank] = ['data' => $category, 'children' => []];
				$references[$globalRank] = &$references[$parentRank]['children'][$globalRank];
			}
		}
	}
	return $tree;
}

// Hàm hiển thị menu dạng HTML từ cây đã tạo
function renderTreeMenu($tree)
{
	$html = '<ul>';
	foreach ($tree as $node) {
		// Xác định cấp độ dựa trên số lượng dấu "." trong global_rank
		$globalRank = $node['data']['global_rank'];
		$levels = explode('.', $globalRank);
		$levelClass = count($levels) === 1 ? 'tree-menu-parent' : 'tree-menu-child';

		// Thêm số lượng ảnh nếu có
		$span = ($node['data']['count_images'] > 0) ? "<span class='image-count'>[{$node['data']['count_images']}]</span>" : "";

		// Tạo thẻ li với class phù hợp
		$html .= "<li class='tree-menu-item $levelClass'>";
		$html .= "<a class='tree-menu-item-link' href='{$node['data']['URL']}'>" . htmlspecialchars($node['data']['name']) . $span . "</a>";

		// Xử lý các node con
		if (!empty($node['children'])) {
			$html .= renderTreeMenu($node['children']);
		}
		$html .= '</li>';
	}
	$html .= '</ul>';
	return $html;
}

add_event_handler('loc_end_page_tail', 'script_js');
add_event_handler('loc_end_page_header', 'add_css_menu_search', EVENT_HANDLER_PRIORITY_NEUTRAL, 1);
function script_js()
{
	echo '<script src="./plugins/rv_menutree/js/main.js"></script>';
	echo '<script src="./plugins/rv_menutree/js/menu_category_search.js"></script>';
}

function add_css_menu_search()
{
	echo '<link rel="stylesheet" href="./plugins/rv_menutree/css/menu-search-custom.css">';
}
