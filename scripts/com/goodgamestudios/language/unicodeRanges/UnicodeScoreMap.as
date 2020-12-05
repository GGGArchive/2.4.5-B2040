package com.goodgamestudios.language.unicodeRanges
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   
   public final class UnicodeScoreMap
   {
       
      
      private var _scores:Vector.<UnicodeScoreToLanguage>;
      
      private var _totalVotes:int = 0;
      
      public function UnicodeScoreMap()
      {
         this._scores = new Vector.<UnicodeScoreToLanguage>();
         super();
      }
      
      public function addOrIncrease(param1:AbstractGGSCountry) : void
      {
         var _loc4_:UnicodeScoreToLanguage = null;
         var _loc5_:UnicodeScoreToLanguage = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < this._scores.length)
         {
            _loc4_ = this._scores[_loc3_];
            if(param1 == _loc4_.country && !_loc2_)
            {
               _loc4_.increaseScore();
               this._totalVotes++;
               _loc2_ = true;
            }
            _loc3_++;
         }
         if(!_loc2_)
         {
            _loc5_ = new UnicodeScoreToLanguage(param1);
            this._scores.push(_loc5_);
            this._totalVotes++;
         }
      }
      
      public function get winnerCountry() : AbstractGGSCountry
      {
         var _loc1_:AbstractGGSCountry = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._scores.length)
         {
            if(this._scores[_loc3_].score > _loc2_)
            {
               _loc1_ = this._scores[_loc3_].country;
               _loc2_ = this._scores[_loc3_].score;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function showStats() : void
      {
         var _loc1_:UnicodeScoreToLanguage = null;
         for each(_loc1_ in this._scores)
         {
            trace(_loc1_.country.ggsCountryCode + " - " + 100 / this._totalVotes * _loc1_.score + "%  " + String(_loc1_.score) + " votes");
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._scores)
         {
            _loc1_ = null;
         }
         this._scores = null;
      }
   }
}
