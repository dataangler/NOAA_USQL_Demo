using Microsoft.Analytics.Interfaces;
using Microsoft.Analytics.Types.Sql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Accord.Statistics.Models.Regression.Linear;

namespace Noaa
{

    public static class Predict
    {
        public static decimal? Regress(int input_feature, SqlMap<int, decimal?> series)
        {
            double[] features = series.Select(kvp => (double)kvp.Key).ToArray(); //years
            double[] labels = series.Select(kvp => (double)kvp.Value).ToArray(); //temps

            SimpleLinearRegression regression = new SimpleLinearRegression();

            regression.Regress(features, labels);   //build regression model

            return (decimal?)regression.Compute(input_feature); //return regression value for input year
        }
    }

}
