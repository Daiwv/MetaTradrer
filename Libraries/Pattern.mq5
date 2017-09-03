//+------------------------------------------------------------------+
//|                                                      Pattern.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "./Bar.mq5"

class Pattern
{
   public:
   
   // If the value is set
   bool IsSet;
   
   // The index of the start of the pattern
   int Index;
   
   // The size of the pattern
   int Size;
   
   // The pattern collection
   Bar Collection[];
   
   Pattern()
   {
      this.SetDefaultValues();
   }
   
   Pattern(Bar &bars[])
   {
      this.Index = 0;
      this.Size = ArraySize(bars);
      ArrayResize(this.Collection, this.Size);
      for(int i=0;i<this.Size;i++)
      {
         this.Collection[i] = bars[i];
      }
      this.IsSet = true;
   }
   
   Pattern(Bar &bars[], int index)
   {
      this.Index = index;
      this.Size = ArraySize(bars);
      ArrayResize(this.Collection, this.Size);
      for(int i=0;i<this.Size;i++)
      {
         this.Collection[i] = bars[i];
      }
      this.IsSet = true;
   }
   
   void SetDefaultValues()
   {
      this.Index = 0;
      this.Size = 0;
      
      this.IsSet = false;
   }
   
   ~Pattern()
   {
      ArrayFree(this.Collection);
   }
};
