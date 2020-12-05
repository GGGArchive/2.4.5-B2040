package com.goodgamestudios.mafia.constants.enums
{
   import flash.utils.getQualifiedClassName;
   
   public class BasicEnum
   {
       
      
      protected var _name:String;
      
      protected var _index:uint;
      
      public function BasicEnum(param1:String, param2:uint)
      {
         super();
         this._name = param1;
         this._index = param2;
      }
      
      public function toString() : String
      {
         return this.getClassName() + "." + this._name;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      protected function getClassName() : String
      {
         return getQualifiedClassName(this).match("[^:]*$")[0];
      }
      
      protected function throwInstantiationError() : void
      {
         throw new Error("Don\'t instantiate " + this.getClassName() + "!");
      }
   }
}
