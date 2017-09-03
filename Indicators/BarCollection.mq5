//+------------------------------------------------------------------+
//|                                                BarCollection.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window

#include "../Libraries/Bar.mq5"
#include "../Libraries/BarCollection.mq5"
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

BarCollection currentBarCollection;
int OnInit()
  {
//--- indicator buffers mapping
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
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
   if(currentBarCollection.IsSet)
   {
      if(rates_total != prev_calculated)
      {
         Bar bar = new Bar(rates_total, prev_calculated, open, high, low, close, tick_volume, volume, spread);
         
         if(bar.IsSet)
         {
            currentBarCollection.AddBar(bar);
            bar.Print();
         }
         else
         {
            Print("Bar Creation Error!");
         }
      }
   }
   else
   {
      currentBarCollection = new BarCollection(rates_total, prev_calculated, time, open, high, low, close, tick_volume, volume, spread);
   }

   return(rates_total);
}

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
