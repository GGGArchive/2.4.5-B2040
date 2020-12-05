package com.goodgamestudios.abTesting
{
   public class ABTestController
   {
      
      private static var _instance:ABTestController;
       
      
      private var _instance:ABTestController;
      
      private var enabledTests:Vector.<ABTest>;
      
      public function ABTestController()
      {
         this.enabledTests = new Vector.<ABTest>();
         super();
         if(this._instance)
         {
            throw new Error("this is a singleton. cannot instanciate more than once");
         }
      }
      
      public static function get instance() : ABTestController
      {
         if(!_instance)
         {
            _instance = new ABTestController();
         }
         return _instance;
      }
      
      public function initialize(param1:XML, param2:int, param3:int, param4:int, param5:String, param6:int, param7:String) : void
      {
         var _loc9_:XML = null;
         var _loc10_:ABTestData = null;
         var _loc8_:XMLList = param1.children();
         for each(_loc9_ in _loc8_)
         {
            _loc10_ = new ABTestData();
            _loc10_._testID = uint(_loc9_.attribute("id"));
            _loc10_.gameID = param2;
            _loc10_.instanceID = param3;
            _loc10_.networkID = param4;
            _loc10_.accountID = param5;
            _loc10_.playerID = param6;
            _loc10_.referrer = param7;
            this.enabledTests.push(new ABTest(_loc10_));
         }
      }
      
      public function getTest(param1:uint) : ABTest
      {
         var _loc2_:int = this.enabledTests.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.enabledTests[_loc3_].testData.testID == param1)
            {
               return this.enabledTests[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getGlobalTest() : ABTest
      {
         if(this.enabledTests.length > 0 && this.enabledTests[0])
         {
            return this.enabledTests[0];
         }
         return null;
      }
      
      public function trackConversion(param1:int, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:int = this.enabledTests.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(this.enabledTests[_loc6_].testData.testID == param1)
            {
               if(this.enabledTests[_loc6_].testData.isValid)
               {
                  this.enabledTests[_loc6_].sendConversion(param2,param3,param4);
               }
            }
            _loc6_++;
         }
      }
   }
}
