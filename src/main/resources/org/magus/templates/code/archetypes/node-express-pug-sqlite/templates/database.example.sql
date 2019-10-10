CREATE TABLE IF NOT EXISTS manufacturer (
	id INTEGER PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS system (
	id INTEGER PRIMARY KEY,
	name type TEXT NOT NULL,
    manufacturer_id INTEGER,
    type TEXT,
    country TEXT,
    year TEXT,
    description TEXT,
    price TEXT,
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (id) 
);

CREATE TABLE IF NOT EXISTS technical_information (
	id INTEGER PRIMARY KEY,
	system_id INTEGER,
    batteries TEXT,
    buttons TEXT,
    built_in_games TEXT,
    colors TEXT,
    controllers TEXT,
    coprocessor TEXT,
    cpu TEXT,
    graphics TEXT,
    gun TEXT,
    keyboard TEXT,
    language TEXT,
    media TEXT,
    num_games TEXT,
    peripherals TEXT,
    ports TEXT,
    power TEXT,
    ram TEXT,
    rom TEXT,
    size TEXT,
    sound TEXT,
    speed TEXT,
    switches TEXT,
    text TEXT,
    vram TEXT,
	FOREIGN KEY (system_id) REFERENCES system (id) 
);

CREATE TABLE IF NOT EXISTS adverts (
	id INTEGER PRIMARY KEY,
	system_id INTEGER,
	FOREIGN KEY (system_id) REFERENCES system (id) 
);
CREATE TABLE IF NOT EXISTS emulators (
	id INTEGER PRIMARY KEY,
	system_id INTEGER,
	FOREIGN KEY (system_id) REFERENCES system (id) 
);
CREATE TABLE IF NOT EXISTS links (
	id INTEGER PRIMARY KEY,
	system_id INTEGER,
	FOREIGN KEY (system_id) REFERENCES system (id) 
);
CREATE TABLE IF NOT EXISTS hardware (
	id INTEGER PRIMARY KEY,
	system_id INTEGER,
	FOREIGN KEY (system_id) REFERENCES system (id) 
);
CREATE TABLE IF NOT EXISTS shots (
	id INTEGER PRIMARY KEY,
	system_id INTEGER,
	FOREIGN KEY (system_id) REFERENCES system (id) 
);
