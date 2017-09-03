//+------------------------------------------------------------------+
//|                                                 BasicExample.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"

#property indicator_buffers 2
#property indicator_plots   2

//--- plot Intersection 
#property indicator_label1  "Intersection" 
#property indicator_type1   DRAW_FILLING 
#property indicator_color1  clrRed,clrBlue 
#property indicator_width1  1 

//--- plot Intersection 
#property indicator_label1  "Intersection" 
#property indicator_type1   DRAW_FILLING 
#property indicator_color1  clrRed,clrBlue 
#property indicator_width1  1 
//--- input parameters 
input int      CandleCount = 5;          // The count of the candle to set the indicator on
//--- Indicator buffers 
double         IntersectionBuffer1[]; 
double         IntersectionBuffer2[]; 

//--- An array to store colors 
color colors[]={clrRed,clrBlue,clrGreen,clrAquamarine,clrBlanchedAlmond,clrBrown,clrCoral,clrDarkSlateGray}; 
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping 
   SetIndexBuffer(0,IntersectionBuffer1,INDICATOR_DATA); 
   SetIndexBuffer(1,IntersectionBuffer2,INDICATOR_DATA); 
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
   for(int i=0;i<rates_total;i++)
     {
      IntersectionBuffer1[i] = open[i];
     }
   for(int i=0;i<rates_total;i++)
     {
      IntersectionBuffer2[i] = close[i];
     }
   
   return(rates_total); 
  } 
//+------------------------------------------------------------------+ 
//| Changes the colors of the channel filling                        | 
//+------------------------------------------------------------------+ 
void ChangeLineAppearance() 
  { 
//--- A string for the formation of information about the line properties 
   string comm=""; 
//--- A block for changing the color of the line 
   int number=MathRand(); // Get a random number 
//--- The divisor is equal to the size of the colors[] array 
   int size=ArraySize(colors); 
  
//--- Get the index to select a new color as the remainder of integer division 
   int color_index1=number%size; 
//--- Set the first color as the PLOT_LINE_COLOR property 
   PlotIndexSetInteger(0,PLOT_LINE_COLOR,0,colors[color_index1]); 
//--- Write the first color 
   comm=comm+"\r\nColor1 "+(string)colors[color_index1]; 
  
//--- Get the index to select a new color as the remainder of integer division 
   number=MathRand(); // Get a random number 
   int color_index2=number%size; 
//--- Set the second color as the PLOT_LINE_COLOR property 
   PlotIndexSetInteger(0,PLOT_LINE_COLOR,1,colors[color_index2]); 
//--- Write the second color 
   comm=comm+"\r\nColor2 "+(string)colors[color_index2]; 
//--- Show the information on the chart using a comment 
   Comment(comm); 
  }
