package com.goodgamestudios.language.unicodeRanges
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   
   public final class UnicodeScoreToLanguage
   {
       
      
      private var _countryVO:AbstractGGSCountry;
      
      private var _score:int = 0;
      
      public function UnicodeScoreToLanguage(param1:AbstractGGSCountry)
      {
         super();
         this._countryVO = param1;
         this._score++;
      }
      
      public function get country() : AbstractGGSCountry
      {
         return this._countryVO;
      }
      
      public function increaseScore() : void
      {
         this._score++;
      }
      
      public function get score() : int
      {
         return this._score;
      }
   }
}
