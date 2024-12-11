<style>
/* Responsive styling */

/* CSS */
/* Chỉnh sửa màu sắc MENU Ở ĐÂY */
:root {
  /* Màu chữ tên menu Albums */
  --albums-color: rgb(63, 63, 63);
  /* Màu chữ link album: */
  --text-color: rgb(63, 63, 63);
  /* Màu nền menu */
  --background-menu-color: #ffffff;
  /* Màu nền khi hover/ di chuột :  */
  --bgcHover-color-link: rgba(154, 152, 152, 0.526);
}
/* Tree menu container styles */
.tree-menu-title {
  display: flex;
  justify-content: center;
  align-items: center;
  width: auto;
  height: auto;
  margin-left: 10px;
}
.tree-menu-title::after {
  content: '\25BC';
  font-size: 8px;
  color: var(--albums-color);
  float: right;
  padding: 3px;
}

.tree-menu-title a {
  text-decoration: none;
  text-align: center;
  color: var(--albums-color);
  margin: 0 auto;
}

.hidden {
  display: none;
}

#rv-menu-container ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  font-family: Arial, sans-serif;
  font-size: 14px;
}

#rv-menu-container {
  border: 1px solid rgba(0, 0, 0, 0.15);
  height: auto;
  max-height: 80vh;
  overflow-x: hidden;
  width: 200px;
  background-color: var(--background-menu-color);
}
.tree-menu {
  flex-direction: column;
}
.tree-menu-item {
  list-style-type: none;
  border-radius: 5px;
  overflow: hidden;
  text-overflow: ellipsis;
}

.tree-menu-item-link {
  display: block;
  text-decoration: none;
  color: var(--text-color);
  padding: 8px 12px;
  background-color: transparent;
  border: 1px solid transparent;
  border-radius: 3px;
  transition: all 0.3s ease;
}

.tree-menu-item-link:hover {
  text-decoration: none;
  background-color: var(--bgcHover-color-link);
  color: var(--text-color);
  border: 1px solid #ddd;
}

.tree-menu-item {
  margin: 5px 0;
}

.tree-menu-item > ul {
  display: none;
  padding-left: 15px;
  margin-top: 5px;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.tree-menu-parent > .tree-menu-item-link::after {
  content: '➕';
  float: right;
  font-size: 12px;
  color: var(--text-color);
  transition: transform 0.3s ease, color 0.3s ease;
}

.tree-menu-parent.open > .tree-menu-item-link::after {
  content: '➖';
  color: var(--text-color);
}

.tree-menu-parent.open > ul {
  display: block;
  opacity: 1;
}

.tree-menu-child {
  margin: 0;
}

.tree-menu-child a {
  color: var(--text-color);
  padding: 6px 0;
  display: block;
  transition: color 0.3s ease, background-color 0.3s ease;
}

.tree-menu-child a:hover {
  background-color: var(--background-menu-color);
  color: var(--text-color);
  
}

.tree-menu-parent.open > .tree-menu-item-link {
  font-weight: 600;
  background-color: var(--bgcHover-color-link);
  border: 1px solid #ddd;
}

.tree-menu-item.tree-menu-child {
  text-align: center;
  padding: 1px;
}

.tree-menu-item:hover {
  background-color: var(--bgcHover-color-link);
}

.totalImages {
  text-align: center;
  color: var(--text-color);
}

@media (min-width: 991.99px) {
  #rv-menu-container.active {
    position: absolute;
    display: block;
    top: 46px;
    left: 0;
    border-radius: 5px;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  }
  #rv-menu-main {
    position: relative;
    width: auto;
    height: auto;
    display: flex;
    justify-content: flex-start;
  }
}

@media (max-width: 991.98px) {
  #rv-menu-container.active {
    position: relative;
    width: 100%;
  }

  .tree-menu-title {
    justify-content: flex-start !important;
  }

  #rv-menu-tree {
    margin: 0;
  }
}

</style>
<div id="rv-menu-main">
   <dt class="tree-menu-title" >
    	<a id="rv-menu-tree" href="#">{'Albums'|@translate}</a>
    </dt>
  <dd>
  <div class="tree-menu hidden" id="rv-menu-container">
  {$RVMT_FINAL}
  {combine_script id='rvmt' load='async' path="plugins/`$RVMT_BASE_NAME`/js/rvtree.min.js"}
  {footer_script}
  var _rvTreeAutoQueue = _rvTreeAutoQueue||[]; _rvTreeAutoQueue.push(  document.getElementById('theCategoryMenu') );
  {/footer_script}
  	<div class=totalImages style="margin-top:4px">{$block->data.NB_PICTURE|@translate_dec:'%d photo':'%d photos'}</div>
  </div>
  </dd>
</div>

