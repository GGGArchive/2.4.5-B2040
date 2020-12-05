package com.goodgamestudios.mafia.view
{
   public dynamic class NewBasicRightGrowButton extends NewBasicStandartButton
   {
       
      
      public function NewBasicRightGrowButton()
      {
         super();
      }
      
      override protected function updateTextfieldPosition() : void
      {
         if(textField)
         {
            textField.x = 0;
         }
      }
      
      override protected function updateBackgroundSize(param1:Number) : void
      {
         if(background)
         {
            background.width = param1 + 20;
         }
      }
      
      override protected function updateBackgroundPosition() : void
      {
         if(background)
         {
            background.x = -10;
         }
      }
      
      override protected function updateDisableMask() : void
      {
         if(disablemask)
         {
            disablemask.width = background.width;
            disablemask.x = -10;
         }
      }
      
      override protected function updateGoldInfoPosition(param1:Number) : void
      {
         if(goldInfo)
         {
            goldInfo.x = param1 - 10;
         }
      }
   }
}
