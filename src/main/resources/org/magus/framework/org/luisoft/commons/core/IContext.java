/*
 * recipe
 * Copyright (C) 2014 L.F.Estivalet <luiz.f.estivalet@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>
 */

/*
 * Created on Ter, 12 Jul 2016 16:06:05 by defaultUser
 */

package org.luisoft.commons.core;

public interface IContext {

	void setAttribute(String key, Object value);

	Object getAttribute(String key);
}
