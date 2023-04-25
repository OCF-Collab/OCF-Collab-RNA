class MetamodelInterchangeNotice {
  constructor(actionsElement) {
    this.actionsElement = actionsElement;

    this.handleInterchangeClick = this.handleInterchangeClick.bind(this);
    this.hideTooltip = this.hideTooltip.bind(this);

    this.init();
  }

  init() {
    this.initTooltip();
    this.bindTriggers();
  }

  initTooltip() {
    this.tooltip = new bootstrap.Tooltip(
      this.tooltipElement(),
      this.tooltipOptions()
    );
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
    return this.actionsElement.querySelectorAll("a");
  }

  async handleInterchangeClick(event) {
    event.preventDefault();

    this.showTooltip();
    this.toggleExportAvailability();

    const response = await fetch(event.target.closest("a").href);
    const blob = await response.blob();
    const link = document.createElement("a");
    const url = URL.createObjectURL(blob);
    link.download = /filename="([^"]+)/.exec(response.headers.get("Content-Disposition"))[1];
    link.href = url;
    link.style.display = "none";
    document.body.appendChild(link);
    link.click();
    link.remove();
    URL.revokeObjectURL(url);

    this.toggleExportAvailability();
  }

  showTooltip() {
    this.tooltip.show();
    setTimeout(this.hideTooltip, 5000);
  }

  hideTooltip() {
    this.tooltip.hide();
  }

  toggleExportAvailability() {
    ["export-spinner", "export-label"].forEach(item => {
      const element = this.tooltipElement().querySelector(`.${item}`);
      element.style.opacity = 1 - getComputedStyle(element).getPropertyValue("opacity");
    });

    this.actionsElement.querySelectorAll(".btn, a").forEach(item => {
      const { classList } = item;

      if (classList.contains("disabled")) {
        classList.remove("disabled");
      } else {
        classList.add("disabled");
      }
    });
  }
}
