$(document).ready( function() {
  if($('#donation-calculator').length) {
    var chart1; // globally available
    function drawCanvasPeople( number ) {
      var buttonsToDraw = number / 10;

      var buttonWidth  = 12;
      var buttonHeight = 12;

      var buttonsPerRow = 60;

      var canvas = document.getElementById('myCanvas');
      canvas.width = buttonsPerRow * buttonWidth;
      canvas.height = Math.ceil( buttonsToDraw / buttonsPerRow ) * buttonHeight;

      if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        person = new Image();
        person.src = "./images/person.png"
  person.onload = function() 
  {
    var col = 0;
    var row = 0;
    for( var num = 0; num < buttonsToDraw; num++ )
    {
      ctx.drawImage( person, buttonWidth*col, buttonHeight*row )
        col++
        if( col >= buttonsPerRow )
        { row++; col = 0; }
    }

  }
      }
    }

    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
    }

    function logslider(value) {
      // value will be between 0 and 100
      var min = 0;
      var max = 100;

      // The result should be between 100 an 10000000
      var minv = Math.log(10000);
      var maxv = Math.log(1000000000);

      // calculate adjustment factor
      var scale = (maxv-minv) / (max-min);

      return Math.exp(minv + scale*(value-min));
    }

    var startingSalary = 30000;
    var endingSalary = 100000;
    var yearsToWork = 40;

    // earningProfile is pairs of [year, salary]
    var earningProfile = [];

    function calculateEarningProfile() {
      for( i = 0; i < yearsToWork; i++ )
      {
        y0 = startingSalary;
        y1 = endingSalary;
        x0 = 0;
        x1 = yearsToWork;
        val = y0 + i * (y1 - y0)/(yearsToWork);
        noise = 0;
        // no noise in last 3 years... looks better!
        //if( i < (yearsToWork - 3) ) {
        //  noise = (0.1 * (Math.random() - 0.5)) * val;
        //}

        earningProfile[i] = [i, val + noise];
      }
    };


    var donationPercentage = 30;
    var earningData = [];
    var donationData = [];

    function fillEarningData( earningProfile ) {
      for( year = 0; year < yearsToWork; year++ )
      {
        var salary = earningProfile[year][1];
        earningData[year] = salary;
      }

      chart1.series[0].setData(earningData);
    }

    function fillDonationData( earningData ) {
      var donationData_graph = [];
      for( year = 0; year < yearsToWork; year++ )
      {
        // inverted % for graph as we want to show it *above* the earnings
        donationData_graph[year] = earningData[year] * (100-donationPercentage)/100;
        donationData[year] = earningData[year] * donationPercentage/100;
      }

      chart1.series[1].setData(donationData_graph);
    }


    function calculateOutput() {
      var total = 0
        var netTotal = 0
        for( year = 0; year < donationData.length; year++ )
        {
          total += donationData[year]
            netTotal += earningData[year] - donationData[year];
        }

      if(netTotal < 0){ netTotal = 0; }

      moneyDonated_total = total.toFixed(0);
      moneyDonated_perDay = moneyDonated_total / (yearsToWork * 365); //leap years!?

      livesSaved_total = (total / 300);
      livesSaved_perDay = ((total / 300) / (yearsToWork * 365));

      $( "#money_donated" ).html("£" + numberWithCommas(moneyDonated_total))
        $( "#net_money_total" ).html("£" + numberWithCommas(netTotal.toFixed(0)))

        $( "#lives_saved_total" ).html( (livesSaved_total).toFixed(0) )
        $( "#lives_saved_per_day" ).html( (livesSaved_perDay).toFixed(2) )


        var livesPerDayStr = "";
      if( livesSaved_perDay <= 1.1 ) {

        if( livesSaved_perDay <= 0.0 ) {
          livesPerDayStr = "You won't save any lives with your donations";
        }
        else {
          livesPerDay = (1/livesSaved_perDay).toFixed(0);
          livesPerDayStr = 'You will save <span class="emphasise">a life every '
            if( livesPerDay > 1){ livesPerDayStr += (livesPerDay+' days')}
            else{ livesPerDayStr += "day"}
          livesPerDayStr += "</span>!";
        }
      }
      else
      {
        livesPerDayStr = 'You will save <span class="emphasise">' + livesSaved_perDay.toFixed(1) + ' lives</span> every day!';
      }
      $( "#lives_per_day" ).html( livesPerDayStr );
    }

    function updateDonationProfile() {
      donationPercentage = $( "#donation_slider" ).slider("value");
    }

    function updateWithNewData() {
      calculateEarningProfile();
      fillEarningData( earningProfile );
      fillDonationData( earningData );
      calculateOutput();
    }

    function startingSalarySliderUpdate( event, ui ) {
      startingSalary = ui.value;
      $( "#starting_salary_value" ).html("£" + numberWithCommas(ui.value) );
      updateWithNewData();
    }

    function roundToNearest5Thousand( val ) {
      flange = val/5000.0;
      return Math.round(flange) * 5000;
    }
    function endingSalarySliderUpdate( event, ui ) {
      endingSalary = logslider(ui.value).toFixed(0);
      endingSalary = roundToNearest5Thousand( endingSalary );
      $( "#ending_salary_value" ).html("£" + numberWithCommas(endingSalary) );
      updateWithNewData();
    }

    function donationSliderUpdate( event, ui ) {
      donationPercentage = ui.value;
      $( "#donation_value" ).html( ui.value + "%" );
      updateWithNewData();
    }

    $(function() {
      $( "#starting_salary_slider" ).slider({
        range: "min",
      value: 30000,
      min: 10000,
      max: 1000000, 
      step: 5000,
      //orientation: 'vertical',
      change: startingSalarySliderUpdate,
      slide: startingSalarySliderUpdate
      });
      $( "#starting_salary_value" ).html( "£" + numberWithCommas($( "#starting_salary_slider" ).slider( "value" )) );

      $( "#ending_salary_slider" ).slider({
        range: "min",
        value: 20,
        min: 0,
        max: 100, 
        step: 1,
        //orientation: 'vertical',
        change: endingSalarySliderUpdate,
        slide: endingSalarySliderUpdate
      });
      $( "#ending_salary_value" ).html( "£" + numberWithCommas(   logslider($( "#ending_salary_slider" ).slider( "value" )).toFixed(0)    )   );


      $( "#donation_slider" ).slider({
        range: "min",
        value: 30,
        min: 0,
        max: 100,
        step: 5,
        //orientation: 'vertical',
        change: donationSliderUpdate,
        slide: donationSliderUpdate
      });

      $( "#donation_value" ).html( $( "#donation_slider" ).slider( "value" ) + "%" );

      chart1 = new Highcharts.Chart({

        chart: {
          renderTo: 'chart-container',
             type: 'area'
        },

             title: {
               text: ''
             },

             xAxis: {
               title: {
                 text: 'years worked'
               }
             },

             yAxis: {
               title: {
                 text: 'salary: £ per year'
               }
             },


             plotOptions: {
               series: {
                 enableMouseTracking: false
               },
               area: {
                 fillOpacity: 0,
                 opacity: 0,
                 marker: {
                   enabled: false,
                   symbol: 'circle',
                   radius: 2,
                   states: {
                     hover: {
                       enabled: true
                     }
                   }
                 }
               }
             },

             series: [{
               name: 'Donations',
               data: [],
               color: '#f30064', // HIC magenta
               opacity: 0
             }, {
               name: 'Remaining income',
               data: [],
               color: '#00ff00',
               opacity: 0
             }]
      });

      updateWithNewData()
    });
  };
});
