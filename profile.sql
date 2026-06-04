create table profiles (
  id uuid primary key,            -- must match auth.users.id
  full_name text,
  email text,
  role text default 'user',       -- 'user' or 'admin'
  created_at timestamp default now()
);

alter table profiles enable row level security;

create policy "Users can read own profile"
on profiles
for select
to authenticated
using (auth.uid() = id);

create policy "Users can insert profile"
on profiles
for insert
to authenticated
with check (auth.uid() = id);


create policy "Users can update own profile"
on profiles
for update
to authenticated
using (auth.uid() = id);



insert into profiles (id, full_name, email, role)
values (
  '3f5c9b8e-2b6a-4b5a-a8a3-9d6c0f123456',
  'Thavi Naidoo',
  'thavi@email.com',
  'admin'
);
