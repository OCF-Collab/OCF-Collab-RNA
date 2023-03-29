class SearchResultList {
  constructor(element) {
    this.click = this.click.bind(this);
    this.element = element;
    this.element.addEventListener("click", this.click);
  }

  click(e) {
    const { target } = e;

    switch (target.dataset.role) {
      case "show-all-competencies":
        e.preventDefault();
        this.showAllCompetencies(target);
        break;
      case "show-ten-competencies":
        e.preventDefault();
        this.showTenCompetencies(target);
        break;
    }
  }

  showAllCompetencies(link) {
    link.parentElement.querySelectorAll(".list-group-item").forEach(item => {
      item.classList.remove("d-none");
    });

    link.parentElement.querySelector("[data-role='show-ten-competencies']").classList.remove("d-none");
    link.classList.add("d-none");
  }

  showTenCompetencies(link) {
    link.parentElement.querySelectorAll(".list-group-item").forEach((item, index) => {
      if (index > 9) {
        item.classList.add("d-none");
      }
    });

    link.parentElement.querySelector("[data-role='show-all-competencies']").classList.remove("d-none");
    link.classList.add("d-none");
  }
}

document.addEventListener("DOMContentLoaded", function() {
  const listElement = document.getElementById("search-results");

  if (listElement) {
    new SearchResultList(listElement);
  }
});
