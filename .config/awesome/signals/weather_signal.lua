return {
   {
      command = 'curl https://api.weatherapi.com/v1/current.json?key='
          .. os.getenv("WEATHER_API_COM_API_KEY")
          .. '&q=' .. os.getenv("WEATHER_API_COM_CITY") .. '&aqi=no',
      interval = 200,
      callback = function(widget, stdout)
         local status = stdout:match('code":([0-9]+)},"wind_mph')
         local temperature = stdout:match('temp_c":(.+),"temp_f')
         awesome.emit_signal("data:weather", status, temperature)
      end
   }
}
