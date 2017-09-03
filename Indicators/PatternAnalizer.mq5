//+------------------------------------------------------------------+
//|                                              PatternAnalizer.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window

#include "../Libraries/PatternAnalizer.mq5"

//--- input parameters
input int      PatternSize = 5;
input double   MaxDiffRatio = 1;

PatternAnalizer analizer;

int OnInit()
{
   analizer = new PatternAnalizer();

   return(INIT_SUCCEEDED);
}


int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   if(!analizer.IsSet)
   {
      analizer = new PatternAnalizer(rates_total, prev_calculated, time, open, high, low, close, tick_volume, volume, spread, PatternSize, MaxDiffRatio);
   }
   else 
   {
      if(rates_total != prev_calculated)
      {
         BarCollection pattern = new BarCollection(time, open, high, low, close, tick_volume, volume, spread, rates_total - PatternSize, rates_total);
         
         if(pattern.IsSet)
         {
            analizer.AddPartternCollection(pattern);
         }
         else
         {
            Print("Bar Creation Error!");
         }
      }
   }

   return(rates_total);
}
  
