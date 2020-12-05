package com.goodgamestudios.basic.vo
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class BasicDialogVO
   {
       
      
      public var name:String;
      
      public var priority:int;
      
      public var delay:int;
      
      public var properties:BasicProperties;
      
      public var blockDialogs:Boolean;
      
      public function BasicDialogVO()
      {
         super();
      }
   }
}
