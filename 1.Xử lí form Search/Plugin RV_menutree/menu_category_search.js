document.addEventListener('DOMContentLoaded', function () {
  fetch('./plugins/rv_menutree/menu-category-api.php')
    .then((response) => {
      if (!response.ok) {
        throw new Error('Network response was not ok ' + response.statusText);
      }
      return response.json();
    })
    .then((data) => {
      console.log(data);
      categoryMenuSearch(data);
    })
    .catch((error) => {
      console.error('Có lỗi xảy ra:', error);
    });

  if (window.location.href.includes('search/psk')) {
    const mcsContainer = document.querySelector('.mcs-container');
    if (mcsContainer) {
      mcsContainer.remove();
    }
  }
});

function categoryMenuSearch(data) {
  const categorySelect = document.getElementById('category-list-menu');
  const subCategorySelect = document.getElementById('sub-category-list-menu');
  const inputSearch = document.getElementById('btn-search-input');

  function getMaxChars(element) {
    const elementWidth = element.offsetWidth;
    const fontSize = window.getComputedStyle(element).fontSize;
    const charWidth = getCharWidth(fontSize);
    return Math.floor(elementWidth / charWidth);
  }

  function getCharWidth(fontSize) {
    const canvas = document.createElement('canvas');
    const context = canvas.getContext('2d');
    context.font = fontSize;
    const charWidth = context.measureText('M').width;
    return charWidth;
  }

  function truncateName(name, maxLength) {
    if (name.length > maxLength) {
      return name.substring(0, maxLength) + '...';
    }
    return name;
  }

  Object.keys(data).forEach((key) => {
    const item = data[key];
    const option = document.createElement('option');
    option.value = item.data.id;
    option.setAttribute('data-id', key);
    const maxChars = getMaxChars(categorySelect);
    option.textContent = truncateName(item.data.name, maxChars);
    categorySelect.appendChild(option);
  });

  function updateSubCategoryOptions() {
    const selectedOption = categorySelect.options[categorySelect.selectedIndex];
    const selectedCategoryId = selectedOption.getAttribute('data-id');
    subCategorySelect.innerHTML =
      '<option value="0">---Sub-Category---</option>';

    if (data[selectedCategoryId] && data[selectedCategoryId].children) {
      Object.keys(data[selectedCategoryId].children).forEach((subKey) => {
        const subCategory = data[selectedCategoryId].children[subKey];
        const subOption = document.createElement('option');
        const maxChars = getMaxChars(subCategorySelect);
        subOption.value = subCategory.data.id;
        subOption.textContent = truncateName(subCategory.data.name, maxChars);
        subCategorySelect.appendChild(subOption);
      });
    }
  }

  function restoreSelections() {
    const savedCategoryId = localStorage.getItem('selectedCategory');
    const savedSubCategoryId = localStorage.getItem('selectedSubCategory');
    const savedKeySearch = localStorage.getItem('keywordSearch');
    if (savedCategoryId) {
      categorySelect.value = savedCategoryId;
      updateSubCategoryOptions();

      if (savedSubCategoryId) {
        subCategorySelect.value = savedSubCategoryId;
      }
    }

    if (savedKeySearch) {
      inputSearch.value = savedKeySearch;
    }
  }

  inputSearch.addEventListener('input', function () {
    const keySearch = inputSearch.value;
    localStorage.setItem('keywordSearch', keySearch);
  });

  function saveSelections() {
    const selectedCategoryId = categorySelect.value;
    const selectedSubCategoryId = subCategorySelect.value;
    localStorage.setItem('selectedCategory', selectedCategoryId);
    localStorage.setItem('selectedSubCategory', selectedSubCategoryId);
  }

  categorySelect.addEventListener('change', function () {
    updateSubCategoryOptions();
    saveSelections();
  });

  subCategorySelect.addEventListener('change', function () {
    saveSelections();
  });

  restoreSelections();
}
