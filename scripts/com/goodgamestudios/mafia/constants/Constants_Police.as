package com.goodgamestudios.mafia.constants
{
   import com.goodgamestudios.mafia.constants.enums.PoliceType;
   
   public class Constants_Police
   {
      
      public static const EFFECT_DURATION:int = 3600;
       
      
      public function Constants_Police()
      {
         super();
      }
      
      public static function getPoliceType(param1:int) : PoliceType
      {
         if(param1 >= 200 && param1 <= 205)
         {
            return PoliceType.Police;
         }
         if(param1 >= 206 && param1 <= 211)
         {
            return PoliceType.SWAT;
         }
         throw new Error("invalid opponent id: there is no police with id " + param1);
      }
   }
}
