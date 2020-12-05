package com.goodgamestudios.mafia.vo.clan
{
   public class FamilyCrestPartVO
   {
       
      
      public var category:int;
      
      public var type:int;
      
      public var variation:int;
      
      public var color:int;
      
      public var costGold:uint;
      
      public function FamilyCrestPartVO()
      {
         super();
      }
      
      public function copy() : FamilyCrestPartVO
      {
         var _loc1_:FamilyCrestPartVO = new FamilyCrestPartVO();
         _loc1_.category = this.category;
         _loc1_.type = this.type;
         _loc1_.variation = this.variation;
         _loc1_.color = this.color;
         _loc1_.costGold = this.costGold;
         return _loc1_;
      }
   }
}
