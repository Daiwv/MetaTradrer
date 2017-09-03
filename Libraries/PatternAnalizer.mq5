//+------------------------------------------------------------------+
//|                                              PatternAnalizer.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "./PatternCollection.mq5"
#include "./BarCollection.mq5"
#include "./PatternMatcher.mq5"

class PatternAnalizer
{
   public:
   
   bool IsSet;
   
   int Size;
   
   int NumberOfPatterns;
   
   double MaxDiffRatio;
   
   int PatternSize;
   
   PatternCollection Collection[];
   
   double MaxDiffRato();
   
   PatternAnalizer()
   {
      this.SetDefaultValues();
   }
   
   PatternAnalizer(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[],
                int patternSize,
                double maxDiffRatio)
   {
      this.Size = 0;
      this.MaxDiffRatio = maxDiffRatio;
      this.PatternSize = patternSize;
      this.NumberOfPatterns = rates_total - this.PatternSize;
      
      BarCollection initialPattern = new BarCollection(time, open, high, low, close, tick_volume, volume, spread, 0, this.PatternSize);
      this.AddPartternCollection(initialPattern);

      for(int i = 1; i < this.NumberOfPatterns; i++)
      {
         BarCollection pattern = new BarCollection(time, open, high, low, close, tick_volume, volume, spread, i, i + this.PatternSize);
         this.AddParttern(pattern);
      }
      
      this.IsSet = true;
   }
   
   void AddParttern(BarCollection &pattern)
   {
      bool isMatched = false;
      for(int i = 0; i < this.Size; i++)
      {
         PatternCollection patterns = this.Collection[i];
         double matchDiffRatio = Matcher::GetDiffRatio(patterns.Collection[0], pattern);
         
         isMatched = this.MaxDiffRatio > matchDiffRatio;
         if(isMatched)
         {
            patterns.AddPattern(pattern);
         }
      }
      
      if(!isMatched)
      {
         this.AddPartternCollection(pattern);  
      }
   }
   
   void AddPartternCollection(BarCollection &pattern)
   {
         ArrayResize(this.Collection, ++this.Size);      
         this.Collection[this.Size - 1] = new PatternCollection();
         this.Collection[this.Size - 1].AddPattern(pattern);
   }
   
   void SetDefaultValues() 
   {
      this.IsSet = false;
      this.MaxDiffRatio = 0.0;
      this.PatternSize = 0;
      this.NumberOfPatterns = 0;
      this.Size = 0;
   }
   
   ~PatternAnalizer()
   {
      ArrayFree(Collection);
   }
};
