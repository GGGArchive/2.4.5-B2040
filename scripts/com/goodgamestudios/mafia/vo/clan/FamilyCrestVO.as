package com.goodgamestudios.mafia.vo.clan
{
   public class FamilyCrestVO
   {
       
      
      public var primary:FamilyCrestPartVO;
      
      public var secondary:FamilyCrestPartVO;
      
      public var banderole:FamilyCrestPartVO;
      
      public function FamilyCrestVO()
      {
         super();
      }
      
      public function copy() : FamilyCrestVO
      {
         var _loc1_:FamilyCrestVO = new FamilyCrestVO();
         _loc1_.primary = this.primary.copy();
         _loc1_.secondary = this.secondary.copy();
         _loc1_.banderole = this.banderole.copy();
         return _loc1_;
      }
   }
}
