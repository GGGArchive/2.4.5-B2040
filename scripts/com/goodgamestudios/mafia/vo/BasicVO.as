package com.goodgamestudios.mafia.vo
{
   public class BasicVO
   {
       
      
      protected var _wodId:int = -1;
      
      protected var _name:String;
      
      protected var _group:String;
      
      protected var _type:String;
      
      public function BasicVO()
      {
         super();
      }
      
      public function get wodId() : int
      {
         return this._wodId;
      }
      
      public function set wodId(param1:int) : void
      {
         this._wodId = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get group() : String
      {
         return this._group;
      }
      
      public function set group(param1:String) : void
      {
         this._group = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function fillFromParamXML(param1:XML) : void
      {
         this.wodId = param1.attribute("id");
         this.group = param1.attribute("g");
         this.name = param1.attribute("n");
         this.type = param1.attribute("t");
      }
   }
}
