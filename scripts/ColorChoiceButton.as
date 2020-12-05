package
{
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   
   public dynamic class ColorChoiceButton extends NewBasicInterfaceButton
   {
       
      
      public function ColorChoiceButton()
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
