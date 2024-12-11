{combine_script id='jquery.ui'  load='async' path='themes/default/js/ui/minified/jquery.ui.core.min.js'}
{combine_script id='jquery.ui.slider' require='jquery.ui' load='async' path='themes/default/js/ui/minified/jquery.ui.slider.min.js'}
{combine_css path="themes/default/js/ui/theme/jquery.ui.slider.css" order=-999}
{combine_script id='doubleSlider' load='footer' require='jquery.ui.slider' path='admin/themes/default/js/doubleSlider.js'}

{combine_script id='jquery.selectize' load='footer' path='themes/default/js/plugins/selectize.min.js'}
{combine_css path="admin/themes/default/fontello/css/animation.css" order=10} {* order 10 is required, see issue 1080 *}
{combine_script id='jquery.tipTip' load='header' path='themes/default/js/plugins/jquery.tipTip.minified.js'}
{combine_css path="themes/default/css/search.css" order=-100}
{combine_css path="themes/default/css/{$themeconf.colorscheme}-search.css" order=-100}
{combine_css path="themes/default/vendor/fontello/css/gallery-icon.css" order=-10} 

{footer_script}
{if isset($GP)}
  global_params = {$GP};
{/if}

{if isset($fullname_of)}
fullname_of_cat = {$fullname_of};
{/if}

{if isset($SEARCH_ID)}
search_id = '{$SEARCH_ID}';
{/if}

str_word_widget_label = "{'Search for words'|@translate|escape:javascript}";
str_tags_widget_label = "{'Tag'|@translate|escape:javascript}";
str_album_widget_label = "{'Album'|@translate|escape:javascript}";
str_author_widget_label = "{'Author'|@translate|escape:javascript}";
str_added_by_widget_label = "{'Added by'|@translate|escape:javascript}";
str_filetypes_widget_label = "{'File type'|@translate|escape:javascript}";

str_rating_widget_label = "{'Rating'|@translate|escape:javascript}";
str_no_rating = "{'no rate'|@translate|escape:javascript}";
str_between_rating= "{'between %d and %d'|@translate}";
str_filesize_widget_label = "{'Filesize'|@translate|escape:javascript}";
str_width_widget_label = "{'Width'|@translate|escape:javascript}";
str_height_widget_label = "{'Height'|@translate|escape:javascript}";
str_ratio_widget_label = "{'Ratio'|@translate|escape:javascript}";
str_ratios_label = [];
str_ratios_label['Portrait'] ="{'Portrait'|@translate|escape:javascript}";
str_ratios_label['square'] = "{'square'|@translate|escape:javascript}";
str_ratios_label['Landscape'] = "{'Landscape'|@translate|escape:javascript}";
str_ratios_label['Panorama'] = "{'Panorama'|@translate|escape:javascript}";

str_empty_search_top_alt = "{'Fill in the filters to start a search'|@translate|escape:javascript}";
str_empty_search_bot_alt = "{'Pre-established filters are proposed, but you can add or remove them using the "Choose filters" button.'|@translate|escape:javascript}";
const str_search_in_ab = '{'Search in albums'|@translate|escape:javascript}';

const prefix_icon = 'gallery-icon-';

{*<!-- sliders config -->*}
  var sliders = {

    {if isset($FILESIZE)}
    filesizes: {  
      values: [{$FILESIZE.list}],
      selected: {
        min: {$FILESIZE.selected.min},
        max: {$FILESIZE.selected.max},
      },
      text: '{'between %s and %s MB'|translate|escape:'javascript'}',
    },
    {/if}

    {if isset($HEIGHT)}
    heights: {
      values: [{$HEIGHT.list}],
      selected: {
        min: {$HEIGHT.selected.min},
        max: {$HEIGHT.selected.max},
      },
      text: '{'between %d and %d pixels'|translate|escape:'javascript'}',
    },
    {/if}

    {if isset($WIDTH)}
    widths: {
      values: [{$WIDTH.list}],
      selected: {
        min: {$WIDTH.selected.min},
        max: {$WIDTH.selected.max},
      },
      text: '{'between %d and %d pixels'|translate|escape:'javascript'}',
    },
    {/if}
  };

  {if $SHOW_FILTER_RATINGS and isset($RATING)}
    var show_filter_ratings = true;
  {else}
    var show_filter_ratings = false;
  {/if}

{/footer_script}

{combine_script id='mcs' load='async' require='jquery' path='themes/default/js/mcs.js'}

{if isset($TAGS_FOUND) or isset($ALBUMS_FOUND)}
<div class="mcs-side-results">
  {if isset($TAGS_FOUND)}
  <div class="mcs-tags-found">
    <span class="mcs-side-badge">{count($TAGS_FOUND)}</span>
    <p>{'Tags found'|@translate}</p>
  </div>
  {/if}
  {if isset($ALBUMS_FOUND)}
  <div class="mcs-albums-found">
    <span class="mcs-side-badge">{count($ALBUMS_FOUND)}</span>
    <p>{'Albums found'|@translate}</p>
  </div>
  {/if}
</div>

  {if isset($TAGS_FOUND)}
<div class="tags-found-popin">
  <div class="tags-found-popin-container">
    <span class="gallery-icon-cancel tags-found-close"></span>
    <div class="mcs-popin-title">{'Tags found'|@translate}</div>
    <div class="mcs-popin-desc">{'Tags listed here match your search by word. Click on one to browse by tag.'|translate}</div>
    <div class="tags-found-container">
    {foreach from=$TAGS_FOUND item=tag_path key=k}
      <div class="tag-item">
        {$tag_path}
      </div>
    {/foreach}
    </div>
  </div>
</div>
  {/if}
  {if isset($ALBUMS_FOUND)}
<div class="albums-found-popin">
  <div class="albums-found-popin-container">
    <span class="gallery-icon-cancel albums-found-close"></span>
    <div class="mcs-popin-title">{'Albums found'|@translate}</div>
    <div class="mcs-popin-desc">{'Albums listed here match your search by word. Click on one to browse by album.'|translate}</div>
    <div class="albums-found-container">
      {foreach from=$ALBUMS_FOUND item=album_path key=k}
        <div class="album-item">
          {$album_path}
        </div>
      {/foreach}
    </div>
  </div>
</div>
  {/if}
{/if}
