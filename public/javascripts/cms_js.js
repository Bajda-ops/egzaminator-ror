function slide_js(div_name)
{
   if ($(div_name).style.display == "none")
   {
        Effect.SlideDown(div_name);
   }
   else
   {
        Effect.SlideUp(div_name);
   }
}

function time_counter(element_id)
{
    document.getElementById(element_id)
}