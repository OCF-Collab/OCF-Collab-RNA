class MetamodelInterchangeNotice {
  constructor(actionsElement) {
    this.actionsElement = actionsElement;

    this.handleInterchangeClick = this.handleInterchangeClick.bind(this);

    this.init();
  }

  init() {
    this.initTooltip();
    this.bindTriggers();
  }

  initTooltip() {
    this.tooltip = new Tooltip(this.tooltipElement(), this.tooltipOptions());
  }

  tooltipElement() {
    return this.actionsElement.querySelector(".btn-group");
  }

  tooltipOptions() {
    return {
      placement: 'right',
      trigger: 'manual',
    };
  }

  bindTriggers() {
    this.interchangeElements().forEach((el) => {
      el.addEventListener("click", this.handleInterchangeClick);
    });
  }

  interchangeElements() {
    return this.actionsElement.querySelectorAll(".dropdown-item");
  }

  handleInterchangeClick(event) {
    this.showTooltip();
    this.showSpinner();
    this.disableButtons();
  }

  showTooltip() {
    this.tooltip.show();
  }

  showSpinner() {
    this.tooltipElement().querySelector(".spinner-border").style.opacity = 1;
    this.tooltipElement().querySelector("span").style.opacity = 0;
  }

  disableButtons() {
    this.actionsElement.querySelectorAll(".btn").forEach((btn) => {
      btn.classList.add("disabled");

    });
  }
}
