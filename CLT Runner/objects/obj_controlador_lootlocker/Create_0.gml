//Configuração da API do LootLocker
LootLockerInitialize("dev_9ceb718c3c8f45cfb43dbc743d3fdbeb", "0.0.0.1", true, 34581)

//Inicializa a seed
inicializar_seed();

//Configuração para que o touch do celular funcione direito
device_mouse_dbclick_enable(false);

//Faz uma outra camada para configuração mobile
if (os_type == os_browser) {
    browser_input_capture(true);
}