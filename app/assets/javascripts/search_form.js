class SearchForm {
  constructor(formElement) {
    this.click = this.click.bind(this);
    this.formElement = formElement;
    this.formElement.addEventListener("click", this.click);
  }

  addFacet() {
    const facet = this.formElement.querySelector(".facet");
    const newFacet = facet.cloneNode(true);

    this.resetFacet(newFacet);
    facet.parentElement.append(newFacet);
  }

  click(e) {
    const { target } = e;

    switch (target.dataset.role) {
      case "add-facet":
        this.addFacet();
        break;
      case "remove-facet":
        this.removeOrResetFacet(target);
        break;
    }
  }

  removeOrResetFacet(button) {
    const facet = button.closest(".facet");

    if (this.formElement.querySelectorAll(".remove-facet").length > 1) {
      facet.remove();
    } else {
      this.resetFacet(facet);
    }

    this.formElement.submit();
  }

  resetFacet(facet) {
    facet.querySelector('select').selectedIndex = 0;
    facet.querySelector('input[type=text]').value = "";

    const checkbox = facet.querySelector('input[type=checkbox]');
    checkbox.checked = false;
    checkbox.id = `facet-${(+new Date).toString(36).slice(-5)}-optional`;
    checkbox.nextElementSibling.htmlFor = checkbox.id;
  }
}

document.addEventListener("DOMContentLoaded", function() {
  const formElement = document.getElementById("search-form");

  if (formElement) {
    new SearchForm(formElement);
  }
});
