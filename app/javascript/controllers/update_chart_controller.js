import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
  }

  update () {
    var project = document.getElementById("project")
    var option = project.options[project.selectedIndex];
    var chartValues = JSON.parse(option.dataset.chartValue);
    var chart = Chartkick.charts["chart-projects-revenues"];

    chart.updateData(chartValues);
  }

}
