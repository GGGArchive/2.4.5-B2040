package
{
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   
   public dynamic class Btn_Fame extends NewBasicInterfaceButton
   {
       
      
      public function Btn_Fame()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
