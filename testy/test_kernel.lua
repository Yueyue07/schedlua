--test_scheduler.lua
package.path = package.path..";../?.lua"

local Kernel = require("schedlua.kernel")()




local function numbers(ending)
	local idx = 0;
	local function fred()
		idx = idx + 1;
		if idx > ending then
			return nil;
		end
		return idx;
	end
	
	return fred;
end

local function task1()
	print("first task, first line")
	yield();
	print("first task, second line")
end

local function task2()
	print("second task, only line")
end

local function counter(name, nCount)
	for num in numbers(nCount) do
		print(name, num);
		yield();
	end
	halt();
end

local function main()
	--local t0 = spawn(counter, "counter1", 5)
	local t1 = spawnPrior(task1,1)
	local t2 = spawnPrior(task2,2)
	--local t3 = spawn(counter, "counter2", 7)
end

run(main)


print("After kernel run...")
