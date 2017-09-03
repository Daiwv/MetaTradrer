//+------------------------------------------------------------------+
//|                                                BarCollection.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "./Bar.mq5"

#property library
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"

class BarCollection
{
   public:
   
   // If the Collection is set
   bool IsSet;
   
   // The holder of the bars
   Bar Collection[];
   
   //
   int Size;
   
   BarCollection()
   {
      this.SetDefaultValues();  
   };
   
   BarCollection(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]
                )
   {
      ArrayResize(this.Collection, rates_total);
      
      for(int i=0; i < rates_total; i++)
      {
         this.Collection[i] = new Bar(i, time, open, high, low, close, tick_volume, volume, spread);
      }
      
      this.Size = rates_total;
      this.IsSet = true;
   };
   
   BarCollection(
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[],
                int from,
                int to
                )
   {
      this.Size = to - from;
      ArrayResize(this.Collection, this.Size);
      
      for(int i = from; i < to; i++)
      {
         this.Collection[i - from] = new Bar(i, time, open, high, low, close, tick_volume, volume, spread);
      }
      
      this.IsSet = true;
   };
   
   void SetDefaultValues()
   {
      this.IsSet = false;
      this.Size = 0;
   }
   
   void AddBar(Bar &bar)
   {
      this.Size++;
      ArrayResize(this.Collection, this.Size);
      
      this.Collection[this.Size - 1] = bar;
   }
   
   ~BarCollection()
   {      
      ArrayFree(this.Collection);
   };
};
