package com.goodgamestudios.textfield.manager
{
   import com.goodgamestudios.textfield.textfield.IAdvancedTextField;
   import flash.text.TextField;
   
   public interface IAdvancedTextFieldFactory
   {
       
      
      function createAdvancedTextField(param1:TextField) : IAdvancedTextField;
   }
}
