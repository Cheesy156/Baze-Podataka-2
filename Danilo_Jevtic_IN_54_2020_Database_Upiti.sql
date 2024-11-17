-- prosecna vrednost poteza na jednom kartaskom stolu
SELECT
    k.id_ks,
    COUNT(DISTINCT ig.id_igrac) AS broj_igraca,
    AVG(p.sum_nov_pot) AS prosecna_vrednost_u_potezu
FROM
    potez p
JOIN
    igrac ig ON ig.id_igrac = p.igrac_id_igrac
JOIN
    partija par ON par.id_par = ig.partija_id_par
JOIN
    kartaskisto k ON k.id_ks  = par.kartaskisto_id_ks
GROUP BY
    k.id_ks
ORDER BY
    prosecna_vrednost_u_potezu DESC;

-- da li klijenti vise udaraju slot igru sa promo akcijom nego bez
SELECT
    k.username,
    p.naz_akc,
    COUNT(u.id_udr) AS broj_udaraca
FROM
    klijent k
JOIN
    udarac u ON u.klijent_username = k.username
LEFT JOIN
    slotigra s ON s.id_slot = u.slotigra_id_slot
LEFT JOIN
    promoakcija p ON p.slotigra_id_slot = s.id_slot
GROUP BY
    k.username, p.naz_akc
ORDER BY
    broj_udaraca DESC;

-- izveštaj o osvojenim tiketima po sportskim dogadjajima
SELECT
    s.naz_spd AS sportski_dogadjaj,
    t.tip_trs AS tip_transakcije,
    COUNT(*) AS broj_transakcija,
    SUM(t.izn_trs) AS ukupan_iznos_transakcije
FROM
    transakcija t
JOIN
    tiket tk ON t.tiket_id_tik = tk.id_tik
JOIN
    igra ig ON tk.id_tik = ig.tiket_id_tik
JOIN
    sportskidogadjaj s ON ig.sportskidogadjaj_id_spd = s.id_spd
WHERE
    t.tip_trs = 'Osvojeni tiket'
GROUP BY
    s.naz_spd, t.tip_trs;
