class DetailsTree {
  constructor(treeElement, detailsElement) {
    this.treeElement = treeElement;
    this.detailsElement = detailsElement;
    this.selectedCompetencyElement = null;

    this.handleFrameworkDetailsToggleClick = this.handleFrameworkDetailsToggleClick.bind(this);
    this.handleDetailsToggleClick = this.handleDetailsToggleClick.bind(this);
    this.handleCollapseToggleClick = this.handleCollapseToggleClick.bind(this);
    this.handleExpandAllClick = this.handleExpandAllClick.bind(this);
    this.handleCollapseAllClick = this.handleCollapseAllClick.bind(this);
  }

  init() {
    this.bindEvents();
    this.selectFramework();
  }

  bindEvents() {
    this.frameworkDetailsToggleElement().addEventListener("click", this.handleFrameworkDetailsToggleClick);

    this.detailsToggleElements().forEach((toggleElement) => {
      toggleElement.addEventListener("click", this.handleDetailsToggleClick);
    });

    this.collapseToggleElements().forEach((toggleElement) => {
      toggleElement.addEventListener("click", this.handleCollapseToggleClick);
    });

    if (this.expandAllToggler()) {
      this.expandAllToggler().addEventListener("click", this.handleExpandAllClick);
      this.collapseAllToggler().addEventListener("click", this.handleCollapseAllClick);
    }
  }

  frameworkDetailsToggleElement() {
    return this.treeElement.querySelector(".framework-header");
  }

  handleFrameworkDetailsToggleClick(event) {
    this.selectFramework();
  }

  selectFramework() {
    const frameworkDetailsElement = this.frameworkElement().querySelector(".details");
    const frameworkDetailsElementClone = frameworkDetailsElement.cloneNode(true);

    this.detailsElement.innerHTML = "";
    this.detailsElement.append(frameworkDetailsElementClone);

    if (this.selectedCompetencyElement) {
      this.selectedCompetencyElement.classList.remove("selected");
      this.selectedCompetencyElement = null;
    }

    this.frameworkElement().classList.add("selected");

    const notice = new MetamodelInterchangeNotice(frameworkDetailsElementClone.querySelector("#framework-actions"));
  }

  frameworkElement() {
    return this.treeElement.querySelector(".framework-item");
  }

  detailsToggleElements() {
    return this.treeElement.querySelectorAll(".details-toggle");
  }

  handleDetailsToggleClick(event) {
    const toggleElement = event.target;
    const competencyElement = toggleElement.closest(".tree-item");
    const competencyDetailsElement = competencyElement.querySelector(".details");

    this.detailsElement.innerHTML = "";
    this.detailsElement.append(competencyDetailsElement.cloneNode(true));

    this.frameworkElement().classList.remove("selected");

    if (this.selectedCompetencyElement) {
      this.selectedCompetencyElement.classList.remove("selected");
    }

    competencyElement.classList.add("selected");
    this.selectedCompetencyElement = competencyElement;
  }

  collapseToggleElements() {
    return this.treeElement.querySelectorAll(".collapse-toggle");
  }

  handleCollapseToggleClick(event) {
    const toggleElement = event.target;
    const competencyElement = toggleElement.closest(".tree-item");
    const isCollapsed = competencyElement.classList.contains('collapsed');
    competencyElement.classList.toggle('collapsed', !isCollapsed);
  }

  expandAllToggler() {
    return this.treeElement.querySelector(".expand-all");
  }

  collapseAllToggler() {
    return this.treeElement.querySelector(".collapse-all");
  }

  handleExpandAllClick(event) {
    this.expandAll();
  }

  expandAll() {
    this.treeElement.querySelectorAll(".collapsed").forEach((el) => {
      el.classList.remove("collapsed");
    });
  }

  handleCollapseAllClick(event) {
    this.collapseAll();
  }

  collapseAll() {
    this.treeElement.querySelectorAll(".tree-item").forEach((el) => {
      el.classList.add("collapsed");
    });
  }
}

document.addEventListener("DOMContentLoaded", function() {
  const treeElement = document.getElementById("tree-view");
  const detailsElement = document.getElementById("details-view");

  if (treeElement) {
    const tree = new DetailsTree(treeElement, detailsElement);
    tree.init();
  }
});
