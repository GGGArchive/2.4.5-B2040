package com.goodgamestudios.basic.model.components
{
   import br.com.stimuli.loading.BulkLoader;
   import com.goodgamestudios.loading.GoodgameLoader;
   import flash.events.EventDispatcher;
   
   public class BasicLoaderData extends EventDispatcher
   {
       
      
      public var itemsLoadedCounter:int = 0;
      
      private var _appLoader:GoodgameLoader;
      
      private var _assetLoader:BulkLoader;
      
      public var downloadRateFrameOne:String;
      
      public function BasicLoaderData()
      {
         this._appLoader = new GoodgameLoader("appLoader");
         this._assetLoader = new BulkLoader("assetLoader");
         super();
      }
      
      public function get appLoader() : GoodgameLoader
      {
         return this._appLoader;
      }
      
      public function get assetLoader() : BulkLoader
      {
         return this._assetLoader;
      }
   }
}
