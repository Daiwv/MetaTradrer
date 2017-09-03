//+------------------------------------------------------------------+
//|                                                          Bar.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"

class Bar {
   public: 
   
   // If the object is set
   bool IsSet;
   
   // Bar Open
   double Open;
    
   // Bar Close
   double Close; 
   
   // Bar High
   double High;
   
   // Bar Low 
   double Low;
   
   // Bar Nubmer of ticks
   long TickVolume;
   
   // ?? 
   long Volume;
   
   // ??
   int Spread;
   
   // The current time of the bar
   datetime Time;
   
   // Default ctor
   Bar ()
   {
      this.SetDefaultValues();
   }
   
   //Copy ctor
   Bar(Bar &bar)
   {
      this.IsSet = bar.IsSet;
      this.Open = bar.Open;
      this.High = bar.High;
      this.Low = bar.Low;
      this.Close = bar.Close;
      this.TickVolume = bar.TickVolume;
      this.Volume = bar.Volume;
      this.Spread = bar.Spread;
      this.Time = bar.Time;
   }
   
   // Set values from OnCalculate
   Bar(int index, const datetime &time[], const double &open[], const double &high[], const double &low[], const double &close[], const long &tick_volume[], const long &volume[], const int &spread[])
   {
      this.Open = open[index];
      this.High = high[index];
      this.Low = low[index];
      this.Close = close[index];
      this.TickVolume = tick_volume[index];
      this.Volume = volume[index];
      this.Spread = spread[index];
      this.Time = time[index];
      
      this.IsSet = true;
   }
   
   
   // Set smart values on OnCalculate
   Bar(int rates_total, int prev_calculated, const datetime &time[],  const double &open[], const double &high[], const double &low[], const double &close[], const long &tick_volume[], const long &volume[], const int &spread[])
   {
      if(rates_total != prev_calculated)
      {
         int index = rates_total - 1;
         
         this.Open = open[index];
         this.High = high[index];
         this.Low = low[index];
         this.Close = close[index];
         this.TickVolume = tick_volume[index];
         this.Volume = volume[index];
         this.Spread = spread[index];
         this.Time = time[index];
         
         this.IsSet = true;
      }
      else 
      {
         this.SetDefaultValues();
      }
   }
   
   ~Bar()
   {
   }
   
   // Set Defaults
   void SetDefaultValues() 
   {
      this.IsSet = false;
      this.Open = 0;
      this.High = 0;
      this.Low = 0;
      this.Close = 0;
      this.TickVolume = 0;
      this.Volume = 0;
      this.Spread = 0;
      this.Time = D'2015.01.01 00:00';
   }
   
   void Print()
   {
         string message = "Bar: { " 
         + "Open = " + DoubleToString(this.Open) 
         + ", Close = " + DoubleToString(this.Close) 
         + ", High = " + DoubleToString(this.High)
         + ", Low = " + DoubleToString(this.Low)
         + ", TickVolume = " + IntegerToString(this.TickVolume)
         + ", Volume = " + IntegerToString(this.Volume)
         + ", Spread = " + IntegerToString(this.Spread)
         + ", IsSet = " + IntegerToString(this.IsSet)
         + ", Time = " + TimeToString(this.Time)
      + " };";
      
      Print(message);
   }
};