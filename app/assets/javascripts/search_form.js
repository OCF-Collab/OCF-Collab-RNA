class SearchForm {
  constructor(element) {
    this.click = this.click.bind(this);
    this.element = element;
    this.element.addEventListener("click", this.click);
  }

  addFacet() {
    const facet = this.element.querySelector(".facet");
    const newFacet = facet.cloneNode(true);

    const checkbox = newFacet.querySelector('input[type=checkbox]');
    checkbox.checked = false;
    checkbox.id = `facet-${(+new Date).toString(36).slice(-5)}-optional`;
    checkbox.nextElementSibling.htmlFor = checkbox.id;

    const text = newFacet.querySelector('input[type=text]');
    text.value = "";

    facet.parentElement.append(newFacet);
  }

  click(e) {
    const { target } = e;

    switch (target.dataset.role) {
      case "add-facet":
        this.addFacet();
        break;
      case "remove-facet":
        this.removeFacet(target);
        break;
    }
  }

  removeFacet(button) {
    if (this.element.querySelectorAll(".remove-facet").length > 1) {
      button.closest(".facet").remove();
    }
  }
}

document.addEventListener("DOMContentLoaded", function() {
  const formElement = document.getElementById("search-form");

  if (formElement) {
    new SearchForm(formElement);
  }
});
