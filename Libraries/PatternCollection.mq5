//+------------------------------------------------------------------+
//|                                            PatternCollection.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "./BarCollection.mq5"

class PatternCollection
{
   public:
   // If the data is set
   bool IsSet;
   
   // The size of the collection
   int Size;
   
   // The Collection of patterns
   BarCollection Collection[];
   
   PatternCollection()
   {
      this.SetDefaultValues();
   }
   
   void SetDefaultValues()
   {
      this.Size = 0;
      this.IsSet = false;
   }
   
   ~PatternCollection()
   {
      ArrayFree(this.Collection);
   }
   
   void AddPattern(BarCollection &pattern)
   {
      if(this.Size == 0)
      {
         this.Size++;
         ArrayResize(this.Collection, 1);
         
         this.Collection[0] = pattern;
         this.IsSet = true;
      }
      else
      {
         this.Size++;
         ArrayResize(this.Collection, this.Size);
         
         this.Collection[this.Size - 1] = pattern;
      }
   }
};
