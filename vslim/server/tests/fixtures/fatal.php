<?php

if (($_GET['mode'] ?? '') === 'fatal') {
    undefined_vslim_server_function();
}

echo 'healthy';
