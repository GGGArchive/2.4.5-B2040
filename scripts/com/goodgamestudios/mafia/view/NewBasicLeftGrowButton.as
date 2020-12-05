package com.goodgamestudios.mafia.view
{
   public dynamic class NewBasicLeftGrowButton extends NewBasicStandartButton
   {
       
      
      public function NewBasicLeftGrowButton()
      {
         super();
      }
      
      override protected function updateTextfieldPosition() : void
      {
         if(textField)
         {
            textField.x = -textField.width;
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
            background.x = -(background.width - 10);
         }
      }
      
      override protected function updateDisableMask() : void
      {
         if(disablemask)
         {
            disablemask.width = background.width;
            disablemask.x = 0 - (background.width - 10);
         }
      }
      
      override protected function updateGoldInfoPosition(param1:Number) : void
      {
         if(goldInfo)
         {
            goldInfo.x = -param1 + 10;
         }
      }
   }
}
