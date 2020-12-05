package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.BoosterShopItemVO;
   
   public class MafiaBoosterAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var boosterTitle:String;
      
      public var boosterCopy:String;
      
      public var boosterVO:BoosterShopItemVO;
      
      public function MafiaBoosterAdvancedTooltipProperties(param1:BoosterShopItemVO, param2:String, param3:String)
      {
         this.boosterVO = param1;
         this.boosterTitle = param2;
         this.boosterCopy = param3;
         super();
      }
   }
}
