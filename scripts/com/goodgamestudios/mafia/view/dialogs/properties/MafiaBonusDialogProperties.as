package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.OfferVO;
   
   public class MafiaBonusDialogProperties extends BasicProperties
   {
       
      
      public var bonus:OfferVO;
      
      public function MafiaBonusDialogProperties(param1:OfferVO)
      {
         this.bonus = param1;
         super();
      }
   }
}
