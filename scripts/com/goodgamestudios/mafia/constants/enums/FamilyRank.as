package com.goodgamestudios.mafia.constants.enums
{
   public class FamilyRank extends BasicEnum
   {
      
      private static var _none:FamilyRank;
      
      private static var _leader:FamilyRank;
      
      private static var _assistant:FamilyRank;
      
      private static var _officer:FamilyRank;
      
      private static var _member:FamilyRank;
       
      
      public function FamilyRank(param1:String, param2:uint, param3:DoNotInstantiate#78)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get Leader() : FamilyRank
      {
         if(_leader == null)
         {
            _leader = new FamilyRank("Leader",1,new DoNotInstantiate#78());
         }
         return _leader;
      }
      
      public static function get Assistant() : FamilyRank
      {
         if(_assistant == null)
         {
            _assistant = new FamilyRank("Assistant",2,new DoNotInstantiate#78());
         }
         return _assistant;
      }
      
      public static function get Officer() : FamilyRank
      {
         if(_officer == null)
         {
            _officer = new FamilyRank("Officer",3,new DoNotInstantiate#78());
         }
         return _officer;
      }
      
      public static function get Member() : FamilyRank
      {
         if(_member == null)
         {
            _member = new FamilyRank("Member",4,new DoNotInstantiate#78());
         }
         return _member;
      }
      
      public static function get None() : FamilyRank
      {
         if(_none == null)
         {
            _none = new FamilyRank("None",5,new DoNotInstantiate#78());
         }
         return _none;
      }
   }
}

class DoNotInstantiate#78
{
    
   
   function DoNotInstantiate#78()
   {
      super();
   }
}
