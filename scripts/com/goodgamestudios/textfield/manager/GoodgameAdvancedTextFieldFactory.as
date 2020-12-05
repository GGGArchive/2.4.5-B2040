package com.goodgamestudios.textfield.manager
{
   import com.goodgamestudios.textfield.textfield.GoodgameTextField;
   import com.goodgamestudios.textfield.textfield.IAdvancedTextField;
   import flash.text.TextField;
   
   public class GoodgameAdvancedTextFieldFactory implements IAdvancedTextFieldFactory
   {
       
      
      public function GoodgameAdvancedTextFieldFactory()
      {
         super();
      }
      
      public function createAdvancedTextField(param1:TextField) : IAdvancedTextField
      {
         return new GoodgameTextField(param1);
      }
   }
}
