#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "../Libraries/Bar.mq5"

#property indicator_separate_window
#property indicator_buffers 3
#property indicator_plots   3

#property indicator_label1  "Tick Volume"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

#property indicator_label2  "Volume"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrGreen
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

#property indicator_label3  "Spread"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrBlue
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1



//--- functions definition
bool HandleBar(Bar &bar);

//--- input parameters
input int      PatternSize = 5;

//--- indicator buffers
double TickVolumeBuffer[];
double VolumeBuffer[];
double SpreadBuffer[];

int OnInit()
{
   SetIndexBuffer(0,TickVolumeBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,VolumeBuffer,INDICATOR_DATA);
   SetIndexBuffer(2,SpreadBuffer,INDICATOR_DATA);
   return(INIT_SUCCEEDED);
}

bool HandleBar(Bar &bar)
{
   string message = "Bar: { " 
         + "Open = " + DoubleToString(bar.Open) 
         + ", Close = " + DoubleToString(bar.Close) 
         + ", High = " + DoubleToString(bar.High)
         + ", Low = " + DoubleToString(bar.Low)
      + "};";
      
   Print(message);
   return true;
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
   for(int i=0;i<rates_total;i++)
     {
      TickVolumeBuffer[i] = tick_volume[i];
     }
     
   for(int i=0;i<rates_total;i++)
     {
      VolumeBuffer[i] = volume[i];
     }
     
   for(int i=0;i<rates_total;i++)
     {
      SpreadBuffer[i] = spread[i];
     }

   Bar bar = new Bar(rates_total, prev_calculated, open, high, low, close, tick_volume, volume, spread);    
   if(bar.IsSet == true)
   {
      bool handleSuccess = HandleBar(bar);
      
      if(!handleSuccess)
      {
         Print("BarHandle Error!");
      }
   }
   
   return(rates_total);
}

void OnTimer()
{

}
  
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
}
