package com.goodgamestudios.mafia.constants.enums
{
   public class RankingListType extends BasicEnum
   {
      
      private static var _none:RankingListType;
      
      private static var _playerDynamic:RankingListType;
      
      private static var _playerAlltime:RankingListType;
      
      private static var _familyDynamic:RankingListType;
      
      private static var _familyAlltime:RankingListType;
       
      
      public function RankingListType(param1:String, param2:uint, param3:DoNotInstantiate#71)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : RankingListType
      {
         if(_none == null)
         {
            _none = new RankingListType("None",0,new DoNotInstantiate#71());
         }
         return _none;
      }
      
      public static function get PlayerDynamic() : RankingListType
      {
         if(_playerDynamic == null)
         {
            _playerDynamic = new RankingListType("PlayerDynamic",1,new DoNotInstantiate#71());
         }
         return _playerDynamic;
      }
      
      public static function get PlayerAlltime() : RankingListType
      {
         if(_playerAlltime == null)
         {
            _playerAlltime = new RankingListType("PlayerAlltime",2,new DoNotInstantiate#71());
         }
         return _playerAlltime;
      }
      
      public static function get FamilyDynamic() : RankingListType
      {
         if(_familyDynamic == null)
         {
            _familyDynamic = new RankingListType("FamilyDynamic",3,new DoNotInstantiate#71());
         }
         return _familyDynamic;
      }
      
      public static function get FamilyAlltime() : RankingListType
      {
         if(_familyAlltime == null)
         {
            _familyAlltime = new RankingListType("FamilyAlltime",4,new DoNotInstantiate#71());
         }
         return _familyAlltime;
      }
   }
}

class DoNotInstantiate#71
{
    
   
   function DoNotInstantiate#71()
   {
      super();
   }
}
