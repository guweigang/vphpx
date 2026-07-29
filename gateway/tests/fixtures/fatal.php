<?php

if (($_GET['mode'] ?? '') === 'fatal') {
    undefined_vphp_gateway_function();
}

echo 'healthy';
