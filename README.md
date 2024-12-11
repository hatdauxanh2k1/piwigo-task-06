<style>
  body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    margin: 20px;
    background-color: #f4f4f4;
    color: #333;
  }
  h1 {
    color: #007bff;
  }
  h4 {
    margin-bottom: 20px;
  }
  ol {
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }
  li {
    margin-bottom: 10px;
  }
  strong {
    color: #007bff;
  }
  code {
    background: #e7e7e7;
    padding: 2px 4px;
    border-radius: 3px;
    font-family: monospace;
  }
  ul {
    margin-top: 5px;
    margin-bottom: 5px;
    padding-left: 20px;
  }
</style>
<h1>TASK 06</h1>
<h4>
  Xem hướng dẫn trực quan hơn tại đây:
  <a href="https://xmind.ai/share/CMVCwRFw?xid=WmPrQGGd">LINK</a>
</h4>
<br />
<ol>
  <li>
    <strong>1. Xử lý Form SEARCH</strong>
    <ul>
      <li>
        Thêm File: <b>search-css.txt</b> vào custom CSS của theme Bootstrap
        Darkroom
      </li>
      <li>
        <strong>Theme Bootstrap Darkroom</strong>
        <ul>
          <li>
            <strong>custom css</strong>
            <ul>
              <li><strong>search-css.txt</strong></li>
            </ul>
          </li>
          <li>
            <strong>header.tpl</strong>
            <ul>
              <li>
                Đường dẫn:
                <code>themes/bootstrap_darkroom/template/header.tpl</code>
              </li>
              <li>Chỉnh sửa</li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        <strong>Plugin RV_menutree</strong>
        <ul>
          <li>
            <strong>menu_category_search.js</strong>
            <ul>
              <li>Tạo mới</li>
              <li>
                Đường dẫn:
                <code>plugins/rv_menutree/js/menu_category_search.js</code>
              </li>
            </ul>
          </li>
          <li>
            <strong>rvtree.js</strong>
            <ul>
              <li>Chỉnh sửa</li>
              <li>
                Đường dẫn: <code>plugins/rv_menutree/js/rvtree.min.js</code>
              </li>
            </ul>
          </li>
          <li>
            <strong>rv_menutree_categories.tpl</strong>
            <ul>
              <li>Chỉnh sửa</li>
              <li>
                Đường dẫn:
                <code
                  >plugins/rv_menutree/template/rv_menutree_categories.tpl</code
                >
              </li>
            </ul>
          </li>
          <li>
            <strong>main.inc.php</strong>
            <ul>
              <li>Chỉnh sửa</li>
              <li>Đường dẫn: <code>plugins/rv_menutree/main.inc.php</code></li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        <strong>Root:</strong>
        <ul>
          <li>
            <strong>ssearch.php</strong>
            <ul>
              <li>Tạo mới</li>
            </ul>
          </li>
          <li>
            <strong>menu-category-api.php</strong>
            <ul>
              <li>Tạo mới</li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        <strong>Theme Default</strong>
        <ul>
          <li>
            <strong>search_filters.inc.tpl</strong>
            <ul>
              <li>Chỉnh sửa</li>
              <li>
                Đường dẫn :
                <code
                  >themes/default/template/include/search_filters.inc.tpl</code
                >
              </li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        <strong>CODE</strong>
        <ul>
          <li><strong>search.txt</strong></li>
        </ul>
      </li>
    </ul>
  </li>

  <li>
    <strong>2. Xử lý Plugin Perso Footer</strong>
    <ul>
      <li>
        <strong>Theme</strong>
        <ul>
          <li>
            <strong>bootstrap_darkroom</strong>
            <ul>
              <li>
                <strong>footer.tpl</strong>
                <ul>
                  <li>
                    Đường dẫn:
                    <code>themes/bootstrap_darkroom/template/footer.tpl</code>
                  </li>
                  <li>Chỉnh sửa</li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        <strong>Cài Plugin Perso Footer</strong>
        <ul>
          <li>
            <strong>Code Footer</strong>
            <ul>
              <li><strong>Footer.txt</strong></li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </li>

  <li>
    <strong>3. Sửa giao diện trình bày Theme Bootstrap Darkroom</strong>
    <ul>
      <li>
        <strong>Hiển thị PC (4) Mobile (2)</strong>
        <ul>
          <li>
            <strong>Theme</strong>
            <ul>
              <li>
                <strong>grid_classes.tpl</strong>
                <ul>
                  <li>
                    Đường dẫn:
                    <code
                      >themes/bootstrap_darkroom/template/grid_classes.tpl</code
                    >
                  </li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        <strong>Custom homepage</strong>
        <ul>
          <li>
            <strong>PWG Stuffs (Plugin)</strong>
            <ul>
              <li>Lưu ý: Cần chạy cùng Plugin (đã custom)</li>
              <li>
                <strong>stuffs_index.css</strong>
                <ul>
                  <li>
                    Đường dẫn:
                    <code>plugins/PWG_Stuffs/theme/stuffs_index.css</code>
                  </li>
                  <li>Chỉnh sửa</li>
                </ul>
              </li>
            </ul>
          </li>
          <li>
            <strong>ExtendedDescription (Plugin)</strong>
            <ul>
              <li>
                <strong>functions.inc.php</strong>
                <ul>
                  <li>
                    Đường dẫn:
                    <code
                      >plugins/ExtendedDescription/include/functions.inc.php</code
                    >
                  </li>
                  <li>Chỉnh sửa</li>
                </ul>
              </li>
            </ul>
          </li>
          <li>
            <strong>Theme</strong>
            <ul>
              <li>
                <strong>index.tpl</strong>
                <ul>
                  <li>
                    Đường dẫn:
                    <code>themes/bootstrap_darkroom/template/index.tpl</code>
                  </li>
                  <li>Chỉnh sửa</li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </li>
</ol>
