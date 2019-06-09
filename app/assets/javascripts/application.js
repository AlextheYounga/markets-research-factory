// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


//export table to excel
function generateExcel() {
    //getting data from our table
    var data_type = 'data:application/vnd.ms-excel';
    var table_div = document.getElementById('table_with_data');
    var table_html = table_div.outerHTML.replace(/ /g, '%20');

    var a = document.createElement('a');
    a.href = data_type + ', ' + table_html;
    a.download = 'TradingEconomicsData.xls';
    a.click();
}


//export table to pdf
function generatePDF() {
  var doc = new jsPDF('l', 'pt');

  var elem = document.getElementById('table_with_data');
  var data = doc.autoTableHtmlToJson(elem);
  doc.autoTable(data.columns, data.rows, {
    margin: {left: 35},
    theme: 'grid',
    tableWidth: 'auto',
    fontSize: 8,
    overflow: 'linebreak',
    }
  );
    
  doc.save('Example_Table_To_PDF.pdf');
}