//+------------------------------------------------------------------+
//|                                               PatternMatcher.mq5 |
//|                                                    Nacho Tsvekov |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Nacho Tsvekov"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "./BarCollection.mq5"

class Matcher
{
   public:
   
   static double GetDiffRatio(BarCollection &first, BarCollection &second)
   {
      double diffRatio = 0.0;
      bool areMatch = (first.Size - second.Size) == 0;
      if(areMatch)
      {
         Bar firstZeroBar = first.Collection[0];
         Bar secondZeroBar = second.Collection[0];
         
         //Calculate the scale
         double firstHeight = firstZeroBar.High - firstZeroBar.Low;
         double secondHeight = secondZeroBar.High - secondZeroBar.Low;
         
         double scale = firstHeight / secondHeight;
         
         //Calculate the base
         double firstBase = firstZeroBar.Low;
         double secondBase = secondZeroBar.Low;
         
         for(int i=0;i<first.Size;i++)
         {
            Bar firsBar = first.Collection[i];
            Bar secondBar = second.Collection[i];
            
            // match open
            diffRatio += MathAbs((firsBar.Open - firstBase) - (secondBar.Open - secondBase) * scale) * 1000;
            
            // match high
            diffRatio += MathAbs((firsBar.High - firstBase) - (secondBar.High - secondBase) * scale) * 1000;
            
            // match low
            diffRatio += MathAbs((firsBar.Low - firstBase) - (secondBar.Low - secondBase) * scale) * 1000;
            
            // match close
            diffRatio += MathAbs((firsBar.Close - firstBase) - (secondBar.Close - secondBase) * scale) * 1000;
         }
      }
      else
      {
         diffRatio = -999999999;
      }
      
      return diffRatio;
   }
};
