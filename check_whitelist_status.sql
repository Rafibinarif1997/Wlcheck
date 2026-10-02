create or replace function public.check_whitelist_status(
  p_wallet_address text
)
returns json
language sql
security definer
set search_path = public
as $$
  select json_build_object(
    'success', true,
    'whitelisted',
    exists (
      select 1
      from public.whitelist_entries
      where lower(trim(wallet_address)) = lower(trim(p_wallet_address))
    )
  );
$$;

grant execute on function public.check_whitelist_status(text)
to anon, authenticated;
